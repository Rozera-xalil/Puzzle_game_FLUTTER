<div align="center">

<!-- Animated Header -->
<img src="https://capsule-render.vercel.app/api?type=waving&color=0:0d0d2b,50:1a1a4e,100:00ffff&height=200&section=header&text=PUZZLE%20NOVA&fontSize=70&fontColor=00ffff&fontAlignY=38&desc=The%20Celestial%20Number%20Challenge&descAlignY=58&descColor=ffffff&animation=fadeIn" width="100%"/>

<!-- Typing Animation -->
<a href="https://git.io/typing-svg">
  <img src="https://readme-typing-svg.demolab.com?font=Orbitron&size=22&pause=1000&color=00FFFF&center=true&vCenter=true&width=700&lines=🌌+A+Sensory+%26+Mental+Odyssey;🎨+Where+Numbers+Dance+%26+Colors+Glow;🧠+100%25+Solvable+%7C+100%25+Addictive;⚡+Built+with+Flutter+%26+Dart;🌠+Victory+Feels+Like+a+Supernova" alt="Typing SVG" />
</a>

<br/>

<!-- Badges -->
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=00FFFF)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)


</div>

---

## 🌌 Enter Another Dimension

> *"This isn't just a game... it's a sensory and mental odyssey that pulls you into a digital cosmos where colors glow, numbers dance, and victory feels like a supernova."*

<div align="center">

### 📸 Screenshots
![winnn](https://github.com/user-attachments/assets/056b6490-6f7b-46b5-8b6f-456752f60a2b)
![how_to_play3](https://github.com/user-attachments/assets/f4b2fe8c-23fb-422f-a69e-96d17420da8c)
![how_to_play2](https://github.com/user-attachments/assets/29655aad-3bd1-40fc-9136-4739897ccccd)
![how_to_play](https://github.com/user-attachments/assets/f39c018f-1217-4ae0-9bf2-e6b6dbb3e1fd)
![game](https://github.com/user-attachments/assets/d0fa42c4-2e84-4f08-af5b-ae7e87f7c87c)
![fivegridd](https://github.com/user-attachments/assets/b064cfe2-b444-4ae1-9813-5f8b7671b2ff)
![fivegrid](https://github.com/user-attachments/assets/057af69f-a767-44d7-ba04-bb86a9ac9185)
![333](https://github.com/user-attachments/assets/09c86c4a-cf64-4471-85b4-f2076ae66331)
![33](https://github.com/user-attachments/assets/677729ff-4f85-49af-aed2-206e50172299)
![home](https://github.com/user-attachments/assets/ef7bdd31-aaf7-4cea-8cb7-8214666fbcaa)

---

## ✨ Features

```
╔══════════════════════════════════════════════════════════╗
║  🎮  THREE REALMS OF CHALLENGE                          ║
║      3×3 Fast & Fierce  │  4×4 Strategic  │  5×5 WAR   ║
╠══════════════════════════════════════════════════════════╣
║  🌟  BREATHTAKING ANIMATIONS — Smooth as Silk           ║
╠══════════════════════════════════════════════════════════╣
║  🌀  LIVING GALAXY BACKGROUND — Breathes & Glows        ║
╠══════════════════════════════════════════════════════════╣
║  🧠  GENIUS SHUFFLE — 100% Solvable, Always             ║
╠══════════════════════════════════════════════════════════╣
║  ⚡  INSTANT VICTORY DETECTION — No Delay               ║
╠══════════════════════════════════════════════════════════╣
║  💡  SMART MOVE INDICATORS — Secret Language of Tiles   ║
╚══════════════════════════════════════════════════════════╝
```

---

## 🎨 Visual Design Philosophy

<table>
<tr>
<td width="33%" align="center">
<h3>🌑 Dark Mode First</h3>
Sleek dark interface that makes neon colors <strong>explode</strong> with intensity
</td>
<td width="33%" align="center">
<h3>🎨 Alien Gradients</h3>
Every color meticulously chosen to <strong>shock your senses</strong> with unforgettable contrast
</td>
<td width="33%" align="center">
<h3>💚 Living Tiles</h3>
Numbers <strong>light up green</strong> when home, pulse when ready to move
</td>
</tr>
</table>

---

## 🧠 The Logic Behind the Magic

```dart
// The Genius: Every puzzle is solvable — guaranteed.
bool isSolvable(List<int> tiles) {
  int inversions = _countInversions(tiles);
  int gridSize = sqrt(tiles.length).toInt();
  
  if (gridSize.isOdd) return inversions.isEven;
  
  int emptyRow = _getEmptyRowFromBottom(tiles, gridSize);
  return emptyRow.isEven ? inversions.isOdd : inversions.isEven;
}
```

| Feature | Implementation |
|---------|---------------|
| 🖌️ Grid Rendering | `CustomPainter` |
| 💨 Animations | `AnimatedBuilder` |
| ✨ Glow Effects | `ShaderMask` |
| 🧩 Solvability | Inversion Count Algorithm |
| 🏆 Win Detection | Real-time State Check |

---

## 🗺️ How to Play

```
  1️⃣  Choose Your Destiny ──► Select 3×3, 4×4, or 5×5
          │
          ▼
  2️⃣  Unleash the Chaos ───► Press PLAY NOW
          │
          ▼
  3️⃣  Dance with Numbers ──► Tap tiles adjacent to empty space
          │
          ▼
  4️⃣  All tiles turn GREEN = 🎆 YOU CONQUERED THE COSMOS!
```

---

## 📦 Installation

```bash
# 1. Clone the repository
git clone https://github.com/Rozera-xalil/Puzzle_game_FLUTTER.git
cd buzzle

# 2. Install dependencies
flutter pub get

# 3. Launch into the cosmos 🚀
flutter run
```

> **Prerequisite:** Flutter SDK installed on your machine.

---

## 🔮 Roadmap

- [x] 🎮 3×3, 4×4, 5×5 Puzzle Grids
- [x] 🌌 Animated Galaxy Background
- [x] 💚 Smart Victory Detection

---

## 👩‍💻 About the Author

<div align="center">

<img src="https://capsule-render.vercel.app/api?type=rect&color=0:0d0d2b,100:1a1a4e&height=3&section=header" width="100%"/>

```
 ██████╗  ██████╗ ███████╗███████╗██████╗  █████╗
 ██╔══██╗██╔═══██╗╚══███╔╝██╔════╝██╔══██╗██╔══██╗
 ██████╔╝██║   ██║  ███╔╝ █████╗  ██████╔╝███████║
 ██╔══██╗██║   ██║ ███╔╝  ██╔══╝  ██╔══██╗██╔══██║
 ██║  ██║╚██████╔╝███████╗███████╗██║  ██║██║  ██║
 ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
```

### **Rozêra Xelîl** ☀️
#### `Full_stack Developer & AI Engineering Student`

🏡 **From:** Rojava &nbsp;&nbsp;|&nbsp;&nbsp;❤️🤍💛💚✌🏻

<br/>


<br/>

> *"2+2=1 ❤️"*
> 

<br/>


</div>

---

<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:00ffff,50:1a1a4e,100:0d0d2b&height=120&section=footer&text=2+2=1✌🏻...&fontSize=24&fontColor=00ffff&animation=fadeIn" width="100%"/>

**⭐ Star this repo if it help u! ⭐**

</div>
