// models/Problem.js
import mongoose from 'mongoose';

const problemSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  description: String,
  suggestedSolution: String,
  image: String,
  status: { type: String, default: 'Pending' }, // "In Progress", "Solved"
  createdAt: { type: Date, default: Date.now },
});

const Problem = mongoose.model('Problem', problemSchema);

// Export the model using ES module export
export default Problem;
