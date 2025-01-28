import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

// Menggunakan daftar cameras global yang diinisialisasi di main.dart
import 'package:duo_clone/main.dart';

class ArScreen extends StatefulWidget {
  const ArScreen({super.key});

  @override
  State<ArScreen> createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> with WidgetsBindingObserver {
  CameraController? cameraController;
  CameraImage? cameraImage;
  bool isProcessing = false;
  String result = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
    _loadModel();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cleanupResources();
    super.dispose();
  }

  Future<void> _cleanupResources() async {
    try {
      _stopCamera();
      await Tflite.close();
    } catch (e) {
      print("Error during cleanup: $e");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  void _initializeCamera() async {
    if (cameras.isEmpty) {
      print("No cameras available.");
      return;
    }

    try {
      _stopCamera();

      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.high,
      );

      await cameraController!.initialize();
      if (!mounted) return;

      setState(() {});

      cameraController!.startImageStream((image) {
        if (!isProcessing) {
          isProcessing = true;
          cameraImage = image;
          _runModelOnFrame();
        }
      });
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  Future<void> _loadModel() async {
    try {
      await Tflite.loadModel(
        model: './assets/models/mobilenet_v1_1.0_224.tflite',
        labels: './assets/models/mobilenet_v1_1.0_224.txt',
      );
      print("Model loaded successfully.");
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  Future<void> _runModelOnFrame() async {
    if (cameraImage == null) return;

    try {
      final recognitions = await Tflite.runModelOnFrame(
        bytesList: cameraImage!.planes.map((plane) => plane.bytes).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 1,
        threshold: 0.1,
        asynch: true,
      );

      if (!mounted) return;

      setState(() {
        result = recognitions?.map((res) {
              return "${res["label"]} ${(res["confidence"] as double).toStringAsFixed(2)}";
            }).join("\n") ??
            "No results";
      });
    } catch (e) {
      print("Error running model on frame: $e");
    } finally {
      isProcessing = false;
    }
  }

  void _stopCamera() {
    if (cameraController != null && cameraController!.value.isInitialized) {
      cameraController!.stopImageStream();
      cameraController!.dispose();
      cameraController = null;
      print("Camera stopped and disposed.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cameraController == null || !cameraController!.value.isInitialized
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // Kamera fullscreen
                SizedBox.expand(
                  child: CameraPreview(cameraController!),
                ),
                // Overlay hasil
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      result.isEmpty ? "Menunggu hasil..." : result,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
