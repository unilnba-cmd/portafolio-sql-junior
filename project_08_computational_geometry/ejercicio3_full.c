#include "raylib.h"
#include <math.h>
#include <stdio.h>

#define N 8

int main() {

    InitWindow(900, 650, "Ejercicio 3 FULL - Sistema de Vigilancia");

    Vector2 puntos[N];

    float cx = 450;
    float cy = 320;

    Color colores[N] = {
        ORANGE, LIME, SKYBLUE, ORANGE,
        LIME, SKYBLUE, ORANGE, LIME
    };

    bool camActiva[N] = { false };

    bool showTriangulation = true;

    SetTargetFPS(60);

    while (!WindowShouldClose()) {

        float t = GetTime();

        // 🎮 CONTROL: mostrar/ocultar triangulación
        if (IsKeyPressed(KEY_V)) showTriangulation = !showTriangulation;

        // 💓 animación
        float offset = 80 + 20 * sin(t * 2);
        float shift  = 60 + 20 * cos(t);

        // 🔷 frente
        puntos[0] = (Vector2){cx - offset, cy - offset};
        puntos[1] = (Vector2){cx + offset, cy - offset};
        puntos[2] = (Vector2){cx + offset, cy + offset};
        puntos[3] = (Vector2){cx - offset, cy + offset};

        // 🔷 fondo
        puntos[4] = (Vector2){cx - offset + shift, cy - offset - shift};
        puntos[5] = (Vector2){cx + offset + shift, cy - offset - shift};
        puntos[6] = (Vector2){cx + offset + shift, cy + offset - shift};
        puntos[7] = (Vector2){cx - offset + shift, cy + offset - shift};

        // 🖱️ CLICK → activar/desactivar cámara
        if (IsMouseButtonPressed(MOUSE_LEFT_BUTTON)) {

            Vector2 mouse = GetMousePosition();

            for (int i = 0; i < N; i++) {

                if (CheckCollisionPointCircle(mouse, puntos[i], 15)) {
                    camActiva[i] = !camActiva[i];
                }
            }
        }

        BeginDrawing();

        ClearBackground((Color){15, 20, 45, 255});

        DrawText("Click: activar camara | V: triangulacion", 20, 20, 20, RAYWHITE);

        int cams = 0;

        // 🔺 triangulación
        if (showTriangulation) {

            Color triColors[3] = {
                (Color){255, 99, 71, 255},
                (Color){60, 179, 113, 255},
                (Color){65, 105, 225, 255}
            };

            for (int i = 0; i < 4; i++) {

                Vector2 a = puntos[i];
                Vector2 b = puntos[(i+1)%4];
                Vector2 c = puntos[i+4];
                Vector2 d = puntos[(i+1)%4 + 4];

                DrawTriangle(a, b, c, Fade(triColors[i%3], 0.25f));
                DrawTriangle(b, c, d, Fade(triColors[(i+1)%3], 0.25f));

                DrawLineEx(a,b,1.2f,BLACK);
                DrawLineEx(b,c,1.2f,BLACK);
                DrawLineEx(c,a,1.2f,BLACK);

                DrawLineEx(b,c,1.2f,BLACK);
                DrawLineEx(c,d,1.2f,BLACK);
                DrawLineEx(d,b,1.2f,BLACK);
            }
        }

        // 🔷 estructura
        for (int i = 0; i < 4; i++) {
            DrawLineEx(puntos[i], puntos[(i+1)%4], 2.5f, WHITE);
            DrawLineEx(puntos[i+4], puntos[(i+1)%4 + 4], 2.5f, WHITE);
            DrawLineEx(puntos[i], puntos[i+4], 2.0f, WHITE);
        }

        // 🔵 cámaras
        for (int i = 0; i < N; i++) {

            DrawCircleV(puntos[i], 9, colores[i]);

            if (camActiva[i]) {

                cams++;

                // círculo de cámara
                DrawCircleLines(puntos[i].x, puntos[i].y, 20, YELLOW);

                // área de cobertura
                float pulse = 40 + 15 * sin(t * 3);
                DrawCircleV(puntos[i], pulse, Fade(YELLOW, 0.08f));

                // 👁️ líneas de visión
                for (int j = 0; j < N; j++) {
                    if (i != j) {
                        DrawLineEx(puntos[i], puntos[j], 0.8f, Fade(YELLOW, 0.3f));
                    }
                }
            }
        }

        // 🧠 info
        DrawText(TextFormat("Camaras activas: %d", cams), 20, 50, 20, YELLOW);

        EndDrawing();
    }

    CloseWindow();
    return 0;
}