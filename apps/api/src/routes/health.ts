import { Router, Request, Response } from 'express';

const router = Router();

/**
 * Health check endpoint
 * GET /health
 */
router.get('/', (req: Request, res: Response) => {
  res.status(200).json({
    status: 'ok',
    service: 'cupcake-api',
    version: '0.1.0',
    timestamp: new Date().toISOString(),
  });
});

/**
 * Detailed health check with dependencies
 * GET /health/detailed
 */
router.get('/detailed', async (req: Request, res: Response) => {
  const health = {
    status: 'ok',
    service: 'cupcake-api',
    version: '0.1.0',
    timestamp: new Date().toISOString(),
    checks: {
      supabase: false,
      openai: false,
    },
  };

  // Check Supabase connection
  try {
    const supabaseUrl = process.env.SUPABASE_URL;
    health.checks.supabase = !!supabaseUrl;
  } catch {
    health.checks.supabase = false;
  }

  // Check OpenAI API key
  health.checks.openai = !!process.env.OPENAI_API_KEY;

  res.status(200).json(health);
});

export default router;
