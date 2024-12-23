// config/db.js
import mongoose from 'mongoose';
import dotenv from 'dotenv';

dotenv.config(); // Configuring dotenv

const connectDB = async () => {
  try {
    const conn = await mongoose.connect(process.env.MONGO_URI);
    console.log(`MongoDB connected: ${conn.connection.host}`);
  } catch (error) {
    console.error('MongoDB connection error:', error);
    process.exit(1); // Exit process if connection fails
  }
};

export default connectDB;
