// ./index.js
import dotenv from 'dotenv';
dotenv.config(); // Configuring dotenv
import express from 'express';
import mongoose from 'mongoose';
import cors from 'cors';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { dirname } from 'path';

import rateLimiter from './middlewares/rateLimiter.js';
import authRoutes from './routes/authRoutes.js';
import profileRoutes from './routes/profileRoutes.js';
import problemRoutes from './routes/problemRoutes.js';
import hackathonRoutes from './routes/hackathonRoutes.js';
import notificationRoutes from './routes/notificationRoutes.js';
import connectDB from './config/db.js';

// Get the current directory name (equivalent to __dirname in CommonJS)
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use(rateLimiter);

// Database connection
connectDB();

// Create the 'uploads' directory if it doesn't exist
const uploadDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir);
}

// Routes
app.get('/', (req, res) => {
    console.log(`Server is running on http://${req.hostname}:${PORT}`);
    res.status(200).send('Server Started Successfully!');
});

// app.get('/', (req, res) => {
//     res.redirect('/api'); // Redirect all requests to `/` to `/api`
// });

// Route to handle `/api` and show a welcome message
app.get('/api', (req, res) => {
    res.send('Welcome to the Resolve Technologies API!');
});

app.use('/api/auth', authRoutes);
app.use('/api/profile', profileRoutes);
app.use('/api/problems', problemRoutes);
app.use('/api/hackathons', hackathonRoutes);
app.use('/api/notifications', notificationRoutes);

// Export the app for testing or modular use
export default app; // Safe and standard practice

// Start server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
