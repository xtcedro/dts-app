#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting full-stack project setup...${NC}"

# Update system packages
echo -e "${GREEN}Updating system packages...${NC}"
sudo apt update && sudo apt upgrade -y

# Install Node.js and npm (if not installed)
if ! command -v node &> /dev/null
then
    echo -e "${GREEN}Installing Node.js and npm...${NC}"
    sudo apt install -y nodejs npm
else
    echo -e "${GREEN}Node.js is already installed.${NC}"
fi

# Create project directory structure
echo -e "${GREEN}Setting up project directories...${NC}"
mkdir -p dominguez-tech/{backend,frontend}

# Set up Backend
echo -e "${GREEN}Initializing backend...${NC}"
cd dominguez-tech/backend
npm init -y
npm install express cors dotenv

# Create backend structure
mkdir -p config controllers middleware models routes

# Create server.js
cat <<EOL > server.js
require("dotenv").config();
const express = require("express");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

app.get("/", (req, res) => res.json({ message: "Dominguez Tech API running..." }));

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(\`Server running on port \${PORT}\`));
EOL

# Create .env file
cat <<EOL > .env
PORT=5000
EOL

cd ..

# Set up Frontend
echo -e "${GREEN}Initializing frontend...${NC}"
cd frontend
npx create-react-app .
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

# Create frontend structure
mkdir -p src/{components,pages,assets}

# Configure Tailwind
cat <<EOL > tailwind.config.js
module.exports = {
  content: ["./src/**/*.{js,jsx,ts,tsx}"],
  theme: {
    extend: {
      colors: {
        primary: "#0A1931",
        gold: "#FFD700",
        white: "#FFFFFF",
      },
    },
  },
  plugins: [],
};
EOL

# Create default Navbar component
cat <<EOL > src/components/Navbar.js
import React from "react";

const Navbar = () => {
  return (
    <nav className="bg-primary text-gold py-4 px-8 flex justify-between items-center sticky top-0 shadow-lg">
      <h1 className="text-2xl font-bold">🚀 Dominguez Tech Solutions</h1>
      <ul className="hidden md:flex gap-6">
        <li className="hover:text-white cursor-pointer">Home</li>
        <li className="hover:text-white cursor-pointer">About</li>
        <li className="hover:text-white cursor-pointer">Services</li>
        <li className="hover:text-white cursor-pointer">Contact</li>
      </ul>
      <button className="bg-gold text-black px-4 py-2 rounded-md">
        Get Started
      </button>
    </nav>
  );
};

export default Navbar;
EOL

# Create App.js
cat <<EOL > src/App.js
import React from "react";
import Navbar from "./components/Navbar";

function App() {
  return (
    <div className="bg-white">
      <Navbar />
      <main className="text-center py-16">
        <h1 className="text-4xl font-extrabold text-primary">Welcome to Dominguez Tech Solutions</h1>
        <p className="text-lg mt-4 text-gray-600">Your gateway to modern tech solutions.</p>
      </main>
    </div>
  );
}

export default App;
EOL

# Create index.js
cat <<EOL > src/index.js
import React from "react";
import ReactDOM from "react-dom";
import "./index.css";
import App from "./App";

ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
  document.getElementById("root")
);
EOL

# Create index.css
cat <<EOL > src/index.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOL

cd ..

# Finish setup
echo -e "${GREEN}Setup complete!${NC}"
echo -e "${GREEN}To start the backend, run: cd backend && node server.js${NC}"
echo -e "${GREEN}To start the frontend, run: cd frontend && npm start${NC}"