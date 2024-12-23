// routes/hackathonRoutes.js
import express from 'express';
import { authenticate, protect } from '../middlewares/authMiddleware.js';
import Hackathon from '../models/Hackathon.js';

const router = express.Router();

// Create a hackathon (Admin only)
router.post('/', authenticate, async (req, res) => {
  try {
    const hackathon = await Hackathon.create(req.body);
    res.status(201).json(hackathon);
  } catch (err) {
    res.status(500).json({ message: 'Error creating hackathon', error: err.message });
  }
});

// Read all hackathons
router.get('/', async (req, res) => {
  try {
    const hackathons = await Hackathon.find();
    res.status(200).json(hackathons);
  } catch (err) {
    res.status(500).json({ message: 'Error fetching hackathons', error: err.message });
  }
});

// Update a hackathon (Admin only)
router.put('/:id', authenticate, async (req, res) => {
  try {
    const hackathon = await Hackathon.findByIdAndUpdate(req.params.id, req.body, { new: true });
    res.status(200).json(hackathon);
  } catch (err) {
    res.status(500).json({ message: 'Error updating hackathon', error: err.message });
  }
});

// Delete a hackathon (Admin only)
router.delete('/:id', authenticate, async (req, res) => {
  try {
    await Hackathon.findByIdAndDelete(req.params.id);
    res.status(200).json({ message: 'Hackathon deleted successfully' });
  } catch (err) {
    res.status(500).json({ message: 'Error deleting hackathon', error: err.message });
  }
});

export default router;
