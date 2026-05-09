# 🧠 Convex Hull - Week 07 | Envolvente Convexa - Semana 07

---

## 📌 📖 Description | Descripción

**EN 🇺🇸**  
This project implements the Convex Hull problem using the Gift Wrapping algorithm (Jarvis March).  
The objective is to determine the smallest convex polygon that encloses a given set of points in a 2D plane.

**ES 🇪🇸**  
Este proyecto implementa el problema del Cierre Convexo utilizando el algoritmo Gift Wrapping (Marcha de Jarvis).  
El objetivo es determinar el polígono convexo más pequeño que encierra un conjunto de puntos en un plano bidimensional.

---

## ⚙️ 🧩 Algorithm | Algoritmo

**EN 🇺🇸**  
The Gift Wrapping algorithm works by:
1. Selecting the leftmost point.
2. Iteratively choosing the next point that forms the smallest angle.
3. Repeating until returning to the starting point.

**ES 🇪🇸**  
El algoritmo Gift Wrapping funciona:
1. Seleccionando el punto más a la izquierda.
2. Escogiendo iterativamente el siguiente punto que forme el menor ángulo.
3. Repitiendo hasta regresar al punto inicial.

---

## 🧮 ⏱️ Complexity | Complejidad

**EN 🇺🇸**  
Time Complexity: **O(n · h)**  
Where:
- `n` = total number of points  
- `h` = number of points in the convex hull  

**ES 🇪🇸**  
Complejidad temporal: **O(n · h)**  
Donde:
- `n` = número total de puntos  
- `h` = número de puntos en la envolvente convexa  

---

## 💻 🛠️ Implementation | Implementación

**EN 🇺🇸**  
The program is written in C and includes:
- A `struct` to represent points
- An orientation function
- The convex hull calculation logic

**ES 🇪🇸**  
El programa está desarrollado en C e incluye:
- Una estructura (`struct`) para representar puntos
- Una función de orientación
- La lógica del cálculo del cierre convexo

---

## ▶️ 🚀 Execution | Ejecución

**EN 🇺🇸**
Compile and run:
```bash
gcc cierre_convexo.c -o programa
./programa