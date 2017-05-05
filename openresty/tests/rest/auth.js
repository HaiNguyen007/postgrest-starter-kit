import {rest_service, jwt, resetdb} from '../common.js';
const request = require('supertest');
const should = require("should");

describe('auth', function() {
  after(function(done){ resetdb(); done(); });
  
  it('login', function(done) {
    rest_service()
      .post('/rpc/login?select=email,token')
      .set('Accept', 'application/vnd.pgrst.object+json')
      .send({ 
        email:"alice@email.com",
        password: "pass"
      })
      .expect('Content-Type', /json/)
      .expect(200, done)
      .expect( r => {
        r.body.email.should.equal('alice@email.com');
      })
  });

});