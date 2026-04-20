# 🧮 Computational Geometry in C: Polygon Triangulation

## 📌 Overview
Interactive computational geometry project developed in C using Raylib, focused on polygon triangulation and dynamic geometric visualization.

---

## 🚀 Features
- Dynamic polygon generation
- Polygon triangulation
- 3-coloring algorithm
- Interactive visual simulation

---

## 🎮 Controls
- Left click → Add points  
- Right click → Remove points  
- Press `C` → Clear screen  

---

## 🧠 Key Concepts
- Computational geometry
- Polygon decomposition
- Graph coloring (3-color theorem)
- Algorithmic optimization in C

---

## 📂 Files
- `ejercicio1_full.c` → Core geometry logic
- `ejercicio2_full.c` → Extended computations
- `ejercicio3_full.c` → Advanced operations

---

## 🎥 Demo
Demo removed due to file size (available upon request)

---

## ⚙️ How to Run

```bash
gcc ejercicio1_full.c -o run
./run

```md
> ⚡ Interactive geometry engine built in C with real-time visualization

💻## ⚠️ Requirements
This project requires the Raylib library for execution.  
If the dependencies are not installed, you can refer to the demo video to see the project in action.

# 🧠 Geometría Computacional - Triangulación PRO

## 📌 Descripción
Proyecto interactivo desarrollado en C utilizando Raylib, enfocado en algoritmos de triangulación y geometría computacional:

- Generación de polígonos dinámicos
- Triangulación
- 3-coloración
- Simulación visual interactiva

---

## 🎮 Controles

- Click izquierdo → agregar puntos
- Click derecho → eliminar puntos
- C → limpiar pantalla
- ↑ / ↓ → cambiar velocidad
- +/- → cambiar número de lados
- SPACE → cambiar colores
- P → pausar

---

## 🎥 Demo

![Demo](demo_pro.gif)

---

## 📹 Video (mejor calidad)

Archivo: `output_social.mp4`

---

## ⚙️ Tecnologías usadas

- Lenguaje C
- Raylib
- Matemática computacional
- FFmpeg (para generación de GIF)

---

## 🚀 Compilación

```bash
gcc ejercicio1_full.c -o full1 -I../include -L../lib -lraylib -lgdi32 -lwinmm -lopengl32 -lm
gcc ejercicio2_full.c -o full2 -I../include -L../lib -lraylib -lgdi32 -lwinmm -lopengl32 -lm
gcc ejercicio3_full.c -o full3 -I../include -L../lib -lraylib -lgdi32 -lwinmm -lopengl32 -lm

💻Este proyecto requiere la libreria Raylib para su ejecución.  En caso de no disponer de las dependencias, se recomienda revisar el video demostrativo incluido.