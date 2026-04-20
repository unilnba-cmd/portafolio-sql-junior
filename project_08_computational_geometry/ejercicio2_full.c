#include "raylib.h"
#include <math.h>

#define MAX_LADOS 20
#define MIN_LADOS 3

int main() {

    InitWindow(900, 650, "Ejercicio 2 FULL - Control Total");

    float cx = 450;
    float cy = 320;

    int N = 6; // número de lados

    Vector2 puntos[MAX_LADOS];

    float speed = 1.0f;
    bool paused = false;

    Color colores[3] = { ORANGE, LIME, SKYBLUE };

    SetTargetFPS(60);

    while (!WindowShouldClose()) {

        float t = GetTime();

        // 🎮 CONTROLES

        if (IsKeyPressed(KEY_P)) paused = !paused;

        if (IsKeyDown(KEY_UP)) speed += 0.01f;
        if (IsKeyDown(KEY_DOWN)) speed -= 0.01f;

        if (IsKeyPressed(KEY_EQUAL) && N < MAX_LADOS) N++;
        if (IsKeyPressed(KEY_MINUS) && N > MIN_LADOS) N--;

        if (IsKeyPressed(KEY_SPACE)) {
            // cambio simple de colores
            Color temp = colores[0];
            colores[0] = colores[1];
            colores[1] = colores[2];
            colores[2] = temp;
        }

        float radio = 120 + 40 * sin(t * 2);

        // 🔄 generar polígono
        for (int i = 0; i < N; i++) {

            float ang = (2 * PI / N) * i;

            if (!paused) {
                ang += t * speed;
            }

            puntos[i].x = cx + cos(ang) * radio;
            puntos[i].y = cy + sin(ang) * radio;
        }

        BeginDrawing();

        ClearBackground((Color){12, 18, 45, 255});

        DrawText("UP/DOWN: velocidad | +/-: lados | P: pausa | SPACE: colores", 20, 20, 20, RAYWHITE);

        DrawText(TextFormat("Lados: %d", N), 20, 50, 20, YELLOW);
        DrawText(TextFormat("Velocidad: %.2f", speed), 20, 80, 20, YELLOW);
        DrawText(TextFormat("FPS: %d", GetFPS()), 20, 110, 20, GREEN);

        // 🔺 triangulación FAN
        for (int i = 1; i < N - 1; i++) {

            DrawTriangle(puntos[0], puntos[i], puntos[i+1], Fade(colores[i%3], 0.3f));

            DrawLineEx(puntos[0], puntos[i], 1.2f, BLACK);
            DrawLineEx(puntos[i], puntos[i+1], 1.2f, BLACK);
            DrawLineEx(puntos[i+1], puntos[0], 1.2f, BLACK);
        }

        // 🔷 contorno
        for (int i = 0; i < N; i++) {
            DrawLineEx(puntos[i], puntos[(i+1)%N], 3.0f, WHITE);
        }

        // 🔵 vértices
        for (int i = 0; i < N; i++) {
            DrawCircleV(puntos[i], 8, colores[i%3]);
        }

        EndDrawing();
    }

    CloseWindow();
    return 0;
}