// ./routes/problemRoutes.js
import express from 'express';
import { authenticate, protect } from '../middlewares/authMiddleware.js';
import Problem from '../models/Problem.js';

const router = express.Router();

// Create a problem
router.post('/', authenticate, async (req, res) => {
  try {
    const {
      title,
      problemDescription,
      impactDescription,
      suggestedSolution,
      selectedIncentive,
      extraInfo,
      allowContact,
      makePublic,
    } = req.body;

    const problem = await Problem.create({
      userId: req.user.id,
      title,
      problemDescription,
      impactDescription,
      suggestedSolution,
      selectedIncentive,
      extraInfo,
      allowContact,
      makePublic,
    });

    res.status(201).json(problem);
  } catch (err) {
    res.status(500).json({ message: 'Error creating problem', error: err.message });
  }
});

// Read all problems (Admin)
router.get('/', authenticate, async (req, res) => {
  try {
    const problems = await Problem.find().populate('userId', 'fullName email');
    res.status(200).json(problems);
  } catch (err) {
    res.status(500).json({ message: 'Error fetching problems', error: err.message });
  }
});

// Update a problem
router.put('/:id', authenticate, async (req, res) => {
  try {
    const problem = await Problem.findByIdAndUpdate(req.params.id, req.body, { new: true });
    res.status(200).json(problem);
  } catch (err) {
    res.status(500).json({ message: 'Error updating problem', error: err.message });
  }
});

// Delete a problem
router.delete('/:id', authenticate, async (req, res) => {
  try {
    await Problem.findByIdAndDelete(req.params.id);
    res.status(200).json({ message: 'Problem deleted successfully' });
  } catch (err) {
    res.status(500).json({ message: 'Error deleting problem', error: err.message });
  }
});

export default router;
