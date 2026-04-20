#include "raylib.h"
#include <math.h>

#define MAX_PUNTOS 100

int main() {

    InitWindow(900, 650, "Ejercicio 1 FULL - Interactivo PRO");

    Vector2 puntos[MAX_PUNTOS];
    int total = 0;

    SetTargetFPS(60);

    while (!WindowShouldClose()) {

        // 👉 CLICK IZQUIERDO: agregar punto
        if (IsMouseButtonPressed(MOUSE_LEFT_BUTTON) && total < MAX_PUNTOS) {
            puntos[total++] = GetMousePosition();
        }

        // 👉 CLICK DERECHO: eliminar último punto
        if (IsMouseButtonPressed(MOUSE_RIGHT_BUTTON) && total > 0) {
            total--;
        }

        // 👉 TECLA C: limpiar todo
        if (IsKeyPressed(KEY_C)) {
            total = 0;
        }

        BeginDrawing();

        ClearBackground((Color){20, 20, 35, 255});

        DrawText("Click: agregar | Click derecho: borrar | C: limpiar", 20, 20, 20, RAYWHITE);

        DrawText(TextFormat("Puntos: %d", total), 20, 50, 20, YELLOW);

        // 🔷 dibujar puntos y líneas
        for (int i = 0; i < total; i++) {

            DrawCircleV(puntos[i], 6, WHITE);

            if (i > 0) {
                DrawLineEx(puntos[i-1], puntos[i], 2.5f, ORANGE);
            }
        }

        // cerrar polígono
        if (total > 2) {
            DrawLineEx(puntos[total-1], puntos[0], 2.5f, ORANGE);
        }

        // 🔺 triangulación tipo FAN
        if (total > 2) {

            for (int i = 1; i < total - 1; i++) {

                DrawTriangle(
                    puntos[0],
                    puntos[i],
                    puntos[i+1],
                    Fade(SKYBLUE, 0.25f)
                );

                DrawLineEx(puntos[0], puntos[i], 1.5f, BLACK);
                DrawLineEx(puntos[i], puntos[i+1], 1.5f, BLACK);
                DrawLineEx(puntos[i+1], puntos[0], 1.5f, BLACK);
            }
        }

        EndDrawing();
    }

    CloseWindow();
    return 0;
}