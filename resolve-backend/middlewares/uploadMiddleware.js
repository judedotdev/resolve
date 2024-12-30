// ./middlewares/uploadMiddleware.js
import multer from 'multer';
import path from 'path';

// Configure multer storage
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads/'); // Store files in 'uploads' folder
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + '-' + path.extname(file.originalname)); // Make file names unique
    },
});

const upload = multer({ storage });

export default upload;
