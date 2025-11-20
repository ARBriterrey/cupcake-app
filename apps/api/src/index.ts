// Load environment variables FIRST, before any other imports
import dotenv from 'dotenv';
import path from 'path';

// Load .env from the api directory (using process.cwd() which is the working directory)
dotenv.config({ path: path.join(process.cwd(), '.env') });
console.log('Loading .env from:', path.join(process.cwd(), '.env'));

import express, { Application } from 'express';
import cors from 'cors';
import helmet from 'helmet';
import morgan from 'morgan';

import healthRoutes from './routes/health';
import { errorHandler } from './middleware/errorHandler';
import { getSupabaseClient } from './services/supabase';

const app: Application = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(helmet()); // Security headers
app.use(cors()); // Enable CORS
app.use(morgan('dev')); // HTTP request logger
app.use(express.json()); // Parse JSON bodies
app.use(express.urlencoded({ extended: true }));

// Routes
app.use('/health', healthRoutes);

// Error handling middleware (must be last)
app.use(errorHandler);

// Start server
app.listen(PORT, () => {
  console.log(`🧁 Cupcake API running on port ${PORT}`);
  console.log(`📊 Environment: ${process.env.NODE_ENV || 'development'}`);

  // Test Supabase connection
  try {
    const client = getSupabaseClient();
    console.log(`✅ Supabase connected: Yes`);
  } catch (error) {
    console.error(`❌ Supabase connection failed:`, error);
  }
});

export default app;
