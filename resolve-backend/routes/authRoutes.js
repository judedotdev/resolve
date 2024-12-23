// routes/authRoutes.js
import express from 'express';
import { check, validationResult } from 'express-validator';
import passport from 'passport';
import bcrypt from 'bcrypt';
import { generateToken, verifyToken } from '../utils/jwt.js';
import User from '../models/User.js';
import jwt from 'jsonwebtoken';
import rateLimiter from '../middlewares/rateLimiter.js';
import { authenticate, protect } from '../middlewares/authMiddleware.js';

const router = express.Router();

// Apply rate limiter to all authentication routes
router.use(rateLimiter);

// Register a new user
router.post('/register', async (req, res) => {
    const { fullName, email, phone, username, password } = req.body;

    // Validate input
    if (!fullName || !email || !phone || !username || !password) {
        return res.status(400).json({ message: 'Please fill in all fields' });
    }

    try {
        // Check if user already exists
        const emailExists = await User.findOne({ email });
        const usernameExists = await User.findOne({ username });
        if (emailExists) {
            return res.status(400).json({ message: 'Email already in use' });
        } else if (usernameExists) {
            return res.status(400).json({ message: 'Username already in use' });
        }

        const hashedPassword = await bcrypt.hash(password, 10);
        const user = await User.create({ fullName, email, phone, username, password: hashedPassword });
        const token = generateToken(user._id);
        res.status(201).json({ message: 'User registered successfully', token, userId: user._id, });
    } catch (err) {
        res.status(500).json({ message: 'Error registering user', error: err.message });
    }
});

// Login a user
router.post('/login', async (req, res) => {
    try {
        const { emailOrUsername, password } = req.body;
        if (!emailOrUsername || !password) {
            return res.status(400).json({ message: 'Please fill in all fields' });
        }

        const user = await User.findOne({
            $or: [{ email: emailOrUsername }, { username: emailOrUsername }],
        });
        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(401).json({ message: 'Invalid credentials' });
        }
        const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: '7d' });
        res.status(200).json({ message: 'Login successful', token, userId: user._id, });
    } catch (err) {
        res.status(500).json({ message: 'Error logging in', error: err.message });
    }
});

// Request password reset link
router.post('/forgot-password', async (req, res) => {
    try {
        const { email } = req.body;
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(404).json({ message: 'Email not found' });
        }
        const resetToken = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: '1h' });
        // Placeholder: Send email with resetToken (using a service like SendGrid or Nodemailer)
        res.status(200).json({ message: 'Password reset link sent', resetToken });
    } catch (err) {
        res.status(500).json({ message: 'Error sending reset link', error: err.message });
    }
});

// Reset password
router.post('/reset-password', async (req, res) => {
    try {
        const { resetToken, newPassword } = req.body;
        const decoded = jwt.verify(resetToken, process.env.JWT_SECRET);
        const hashedPassword = await bcrypt.hash(newPassword, 10);
        await User.findByIdAndUpdate(decoded.id, { password: hashedPassword });
        res.status(200).json({ message: 'Password updated successfully' });
    } catch (err) {
        res.status(400).json({ message: 'Invalid or expired token', error: err.message });
    }
});

// Initiate Google Login
router.get('/google', passport.authenticate('google', { scope: ['profile', 'email'] }));

// Google OAuth Callback
router.get(
    '/google/callback',
    passport.authenticate('google', { failureRedirect: '/login', session: false }),
    (req, res) => {
        // Generate JWT token
        const token = jwt.sign({ id: req.user._id }, process.env.JWT_SECRET, {
            expiresIn: '1h',
        });
        res.json({ token });
    }
);

// Initiate Facebook Login
router.get('/facebook', passport.authenticate('facebook', { scope: ['email'] }));

// Facebook OAuth Callback
router.get(
    '/facebook/callback',
    passport.authenticate('facebook', { failureRedirect: '/login', session: false }),
    (req, res) => {
        // Generate JWT token
        const token = jwt.sign({ id: req.user._id }, process.env.JWT_SECRET, {
            expiresIn: '1h',
        });
        res.json({ token });
    }
);


export default router;
