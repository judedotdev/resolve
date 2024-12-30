// ./models/Problem.js
import mongoose from 'mongoose';

const problemSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  title: { type: String, required: true },
  problemDescription: { type: String, required: true },
  impactDescription: { type: String, required: true },
  suggestedSolution: { type: String, required: false },
  selectedIncentive: { type: String, required: false },
  extraInfo: { type: String, required: false },
  allowContact: { type: Boolean, default: false },
  makePublic: { type: Boolean, default: false },
  image: String,
  status: { type: String, default: 'Pending' }, // "In Progress", "Solved"
}, { timestamps: true });

// Use mongoose.models to check if the model is already created
const Problem = mongoose.models.Problem || mongoose.model('Problem', problemSchema);

// Export the model using ES module export
export default Problem;
