// routes/notificationRoutes.js
import express from 'express';
import { authenticate, protect } from '../middlewares/authMiddleware.js';
import Notification from '../models/Notification.js';

const router = express.Router();

// Create a notification
router.post('/', authenticate, async (req, res) => {
  try {
    const notification = await Notification.create({ ...req.body, userId: req.user.id });
    res.status(201).json(notification);
  } catch (err) {
    res.status(500).json({ message: 'Error creating notification', error: err.message });
  }
});

// Get user notifications
router.get('/', authenticate, async (req, res) => {
  try {
    const notifications = await Notification.find({ userId: req.user.id });
    res.status(200).json(notifications);
  } catch (err) {
    res.status(500).json({ message: 'Error fetching notifications', error: err.message });
  }
});

// Mark a notification as read
router.put('/:id', authenticate, async (req, res) => {
  try {
    const notification = await Notification.findByIdAndUpdate(req.params.id, { isRead: true }, { new: true });
    res.status(200).json(notification);
  } catch (err) {
    res.status(500).json({ message: 'Error updating notification', error: err.message });
  }
});

// Delete a notification
router.delete('/:id', authenticate, async (req, res) => {
  try {
    await Notification.findByIdAndDelete(req.params.id);
    res.status(200).json({ message: 'Notification deleted successfully' });
  } catch (err) {
    res.status(500).json({ message: 'Error deleting notification', error: err.message });
  }
});

export default router;
