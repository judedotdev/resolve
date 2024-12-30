// ./models/Hackathon.js
import mongoose from 'mongoose';

const hackathonSchema = new mongoose.Schema({
  title: String,
  description: String,
  startDate: Date,
  endDate: Date,
  prizes: [String],
  status: { type: String, default: 'Upcoming' }, // "Upcoming", "Ongoing", "Completed"
  participants: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
  createdAt: { type: Date, default: Date.now },
});

const Hackathon = mongoose.model('Hackathon', hackathonSchema);

// Export the model using ES module export
export default Hackathon;
