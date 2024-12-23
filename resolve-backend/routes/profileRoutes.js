// routes/profileRoutes.js
import express from 'express';
import passport from 'passport';
import bcrypt from 'bcrypt';
import { generateToken, verifyToken } from '../utils/jwt.js';
import User from '../models/User.js';
import upload from '../middlewares/uploadMiddleware.js';
import { authenticate, protect } from '../middlewares/authMiddleware.js';

const router = express.Router();

// Get user profile
router.get('/me', authenticate, async (req, res) => {
    try {
        const user = await User.findById(req.user.id).select('-password');
        res.status(200).json(user);
    } catch (err) {
        res.status(500).json({ message: 'Error fetching profile', error: err.message });
    }
});

// Update user profile
router.put('/me', authenticate, async (req, res) => {
    try {
        const updatedData = req.body;
        const user = await User.findByIdAndUpdate(req.user.id, updatedData, { new: true }).select('-password');
        res.status(200).json(user);
    } catch (err) {
        res.status(500).json({ message: 'Error updating profile', error: err.message });
    }
});

// Update profile picture
router.put('/profile-picture', protect, upload.single('profilePicture'), async (req, res) => {
    try {
        const user = await User.findById(req.user.id);
        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        user.profilePicture = `/uploads/${req.file.filename}`; // Save the file path in the user record
        await user.save();

        res.status(200).json({ message: 'Profile picture updated', profilePicture: user.profilePicture });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Delete user account
router.delete('/me', authenticate, async (req, res) => {
    try {
        await User.findByIdAndDelete(req.user.id);
        res.status(200).json({ message: 'Account deleted successfully' });
    } catch (err) {
        res.status(500).json({ message: 'Error deleting account', error: err.message });
    }
});

export default router;