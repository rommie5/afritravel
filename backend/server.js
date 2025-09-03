const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const mongoSanitize = require('express-mongo-sanitize');
const xss = require('xss-clean');
const hpp = require('hpp');
const rateLimit = require('express-rate-limit');
require('dotenv').config();

const connectDatabase = require('./config/database');

// Route files
const destinations = require('./routes/destinations');
const auth = require('./routes/auth');
const users = require('./routes/users');
const itineraries = require('./routes/itineraries');

// Connect to database
connectDatabase();

const app = express();

// Body parser
app.use(express.json({ limit: '10mb' }));

// Security middleware
app.use(helmet());
app.use(mongoSanitize());
app.use(xss());
app.use(hpp());

// Rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // limit each IP to 100 requests per windowMs
});
app.use(limiter);

// CORS
app.use(cors());

// Mount routers
app.use('/api/v1/destinations', destinations);
app.use('/api/v1/auth', auth);
app.use('/api/v1/users', users);
app.use('/api/v1/itineraries', itineraries);

// Handle unhandled routes
app.all('*', (req, res, next) => {
  res.status(404).json({
    success: false,
    message: `Route ${req.originalUrl} not found`
  });
});

const PORT = process.env.PORT || 5000;

const server = app.listen(PORT, () => {
  console.log(`Server running in ${process.env.NODE_ENV} mode on port ${PORT}`);
});

// Handle unhandled promise rejections
process.on('unhandledRejection', (err, promise) => {
  console.log(`Error: ${err.message}`);
  server.close(() => {
    process.exit(1);
  });
});