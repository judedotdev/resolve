// ./test/user.test.js
import request from 'supertest';
import { expect } from 'chai';
import app from '../server.js'; // Import server

describe('User Routes', () => {
  it('should create a user', async () => {
    const res = await request(app).post('/api/auth/register').send({
      fullName: 'Test User 1',
      email: 'test1@example.com',
      phone: '+2341234567890',
      username: 'testuser1',
      password: 'password123',
    });
    expect(res.status).to.equal(201);
    expect(res.body).to.have.property('userId');
  });

  it('should not create a user with missing fields', async () => {
    const res = await request(app).post('/api/auth/register').send({
      email: 'test@example.com',
    });
    expect(res.status).to.equal(400);
  });
});
