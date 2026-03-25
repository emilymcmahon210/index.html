<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Spin Me</title>
  <style>
    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background: linear-gradient(to bottom right, #ffd1dc, #ffe6f0);
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      flex-direction: column;
      color: #7a2954;
      text-align: center;
      padding: 20px;
    }

    h1 {
      margin-bottom: 10px;
    }

    .wheel-wrap {
      position: relative;
      width: 450px;
      height: 450px;
    }

    .pointer {
      width: 0;
      height: 0;
      border-left: 18px solid transparent;
      border-right: 18px solid transparent;
      border-top: 28px solid #d63384;
      position: absolute;
      top: -8px;
      left: 50%;
      transform: translateX(-50%);
      z-index: 5;
    }

    .wheel {
      width: 450px;
      height: 450px;
      border-radius: 50%;
      border: 5px solid #d63384;
      position: relative;
      transition: transform 4s ease-out;
      background: conic-gradient(
        #ffb6c1 0deg 72deg,
        #ff85a2 72deg 144deg,
        #ff69b4 144deg 216deg,
        #ff4d94 216deg 288deg,
        #ffd1dc 288deg 360deg
      );
      box-shadow: 0 8px 20px rgba(0,0,0,0.12);
    }

    .center-circle {
      position: absolute;
      width: 100px;
      height: 100px;
      background: white;
      border: 4px solid #d63384;
      border-radius: 50%;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      z-index: 4;
      display: flex;
      justify-content: center;
      align-items: center;
      text-align: center;
      font-size: 15px;
      font-weight: bold;
      color: #d63384;
      padding: 10px;
      box-sizing: border-box;
      line-height: 1.2;
      overflow: hidden;
    }

    button {
      margin-top: 28px;
      padding: 12px 28px;
      border: none;
      border-radius: 999px;
      background: #d63384;
      color: white;
      font-size: 16px;
      cursor: pointer;
      box-shadow: 0 6px 14px rgba(214, 51, 132, 0.25);
    }

    button:hover {
      opacity: 0.95;
    }

    .big-message {
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%) scale(0.5);
      background: white;
      color: #d63384;
      padding: 30px 40px;
      border-radius: 20px;
      font-size: 28px;
      font-weight: bold;
      text-align: center;
      box-shadow: 0 10px 30px rgba(0,0,0,0.2);
      opacity: 0;
      z-index: 10;
      transition: all 0.4s ease;
      overflow: visible;
    }

    .big-message.show {
      opacity: 1;
      transform: translate(-50%, -50%) scale(1);
    }

   .sparkle {
  position: fixed;
  font-size: 22px;
  pointer-events: none;
  z-index: 30;
  animation: sparkle-pop 1.2s ease-out forwards;
}

@keyframes sparkle-pop {
  0% {
    opacity: 0;
    transform: scale(0.4);
  }
  20% {
    opacity: 1;
    transform: scale(1);
  }
  100% {
    opacity: 0;
    transform: translateY(-25px) scale(1.3);
  }
}
  </style>
</head>
<body>
  <h1>Spin Me!</h1>

  <div class="wheel-wrap">
    <div class="pointer"></div>
    <div class="wheel" id="wheel"></div>
    <div class="center-circle" id="centerText">💖</div>
  </div>

  <button onclick="spinWheel()">Spin</button>

  <div id="bigMessage" class="big-message"></div>

  <script>
    const messages = [
      "I hope you have an amazing day!",
      "You are doing great!",
      "Thank you for all that you do!",
      "You deserve good things!",
      "Keep Being YOU!"
    ];

    const wheel = document.getElementById("wheel");
    const centerText = document.getElementById("centerText");
    const bigMessage = document.getElementById("bigMessage");

    let currentRotation = 0;
    let spinning = false;

    function createSparklesAroundMessage() {
  const rect = bigMessage.getBoundingClientRect();

  const sparklePositions = [
    { x: rect.left - 10, y: rect.top + rect.height / 2 },
    { x: rect.right - 10, y: rect.top + rect.height / 2 },
    { x: rect.left + rect.width / 2, y: rect.top - 10 },
    { x: rect.left + rect.width / 2, y: rect.bottom - 10 },
    { x: rect.left + 20, y: rect.top + 20 },
    { x: rect.right - 20, y: rect.top + 20 },
    { x: rect.left + 20, y: rect.bottom - 20 },
    { x: rect.right - 20, y: rect.bottom - 20 }
  ];

  for (let i = 0; i < 12; i++) {
    const sparkle = document.createElement("div");
    sparkle.className = "sparkle";
    sparkle.textContent = "✨";

    const pos = sparklePositions[Math.floor(Math.random() * sparklePositions.length)];
    const offsetX = (Math.random() - 0.5) * 20;
    const offsetY = (Math.random() - 0.5) * 20;

    sparkle.style.left = `${pos.x + offsetX}px`;
    sparkle.style.top = `${pos.y + offsetY}px`;

    document.body.appendChild(sparkle);

    setTimeout(() => {
      sparkle.remove();
    }, 1200);
  }
}

    function spinWheel() {
      if (spinning) return;
      spinning = true;

      centerText.textContent = "💖";
      bigMessage.classList.remove("show");
      bigMessage.innerHTML = "";

      const selectedIndex = Math.floor(Math.random() * messages.length);
      const segmentAngle = 360 / messages.length;

      const extraSpins = 5 * 360;
      const targetAngle = 360 - (selectedIndex * segmentAngle) - (segmentAngle / 2);
      const finalRotation = extraSpins + targetAngle;

      currentRotation += finalRotation;
      wheel.style.transform = `rotate(${currentRotation}deg)`;

      setTimeout(() => {
        const message = messages[selectedIndex];

        centerText.textContent = message;
        bigMessage.textContent = message;
        bigMessage.classList.add("show");

        createSparklesAroundMessage();

        setTimeout(() => {
          bigMessage.classList.remove("show");
        }, 2500);

        spinning = false;
      }, 4000);
    }
  </script>
</body>
</html>
