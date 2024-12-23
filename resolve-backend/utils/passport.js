// const passport = require('passport');
// const GoogleStrategy = require('passport-google-oauth20').Strategy;
// const User = require('../models/User'); // Assume User model is defined
// const FacebookStrategy = require('passport-facebook').Strategy;
import passport from 'passport';
import { Strategy as GoogleStrategy } from 'passport-google-oauth20';
import { Strategy as FacebookStrategy } from 'passport-facebook';
import User from '../models/User.js'; // Assume User model is defined

passport.use(
    new GoogleStrategy(
        {
            clientID: process.env.GOOGLE_CLIENT_ID,
            clientSecret: process.env.GOOGLE_CLIENT_SECRET,
            callbackURL: process.env.GOOGLE_CALLBACK_URL,
        },
        async (accessToken, refreshToken, profile, done) => {
            try {
                // Check if user exists
                let user = await User.findOne({ googleId: profile.id });
                if (!user) {
                    // Create new user
                    user = await User.create({
                        googleId: profile.id,
                        fullName: profile.displayName,
                        email: profile.emails[0].value,
                        profilePicture: profile.photos[0].value,
                    });
                }
                return done(null, user);
            } catch (err) {
                return done(err, null);
            }
        }
    )
);

passport.serializeUser((user, done) => done(null, user.id));
passport.deserializeUser((id, done) =>
    User.findById(id).then((user) => done(null, user))
);

passport.use(
    new FacebookStrategy(
        {
            clientID: process.env.FACEBOOK_APP_ID,
            clientSecret: process.env.FACEBOOK_APP_SECRET,
            callbackURL: process.env.FACEBOOK_CALLBACK_URL,
            profileFields: ['id', 'emails', 'name', 'photos'],
        },
        async (accessToken, refreshToken, profile, done) => {
            try {
                // Check if user exists
                let user = await User.findOne({ facebookId: profile.id });
                if (!user) {
                    // Create new user
                    user = await User.create({
                        facebookId: profile.id,
                        fullName: `${profile.name.givenName} ${profile.name.familyName}`,
                        email: profile.emails[0]?.value || 'No email provided',
                        profilePicture: profile.photos[0].value,
                    });
                }
                return done(null, user);
            } catch (err) {
                return done(err, null);
            }
        }
    )
);
