// ./models/User.js
import mongoose from 'mongoose';
import bcrypt from 'bcrypt';

const userSchema = new mongoose.Schema({
  firstName: { type: String, required: true },
  lastName: { type: String, required: true },
  email: { type: String, unique: true, required: true },
  phone: { type: String, required: true },
  username: { type: String, unique: true, required: true },
  password: String, // Null if OAuth is used
  authProvider: { type: String, default: 'email' }, // "google", "facebook", "email"
  socialId: String, // Only for OAuth
  profilePicture: { type: String, default: '' }, // Optional Profile Picture - URL of the uploaded profile picture
  deviceToken: String,
  country: { type: String, required: false },
  gender: { type: String, enum: ['male', 'female', 'other'], required: false },
  dateOfBirth: { type: Date, required: false },
  role: { type: String, enum: ['user', 'admin'], default: 'user' }, // Default role
}, { timestamps: true });

userSchema.methods.matchPassword = async function (enteredPassword) {
  return await bcrypt.compare(enteredPassword, this.password); // Compare entered password with hashed password
};

// Use mongoose.models to check if the model is already created
const User = mongoose.models.User || mongoose.model('User', userSchema);

// Export the User model as default
export default User;
