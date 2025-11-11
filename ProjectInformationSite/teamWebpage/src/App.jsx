import { useState } from 'react'
import './App.css'
import teamPhoto from './assets/team_photo.jpeg'

function App() {
  return (
    <div className="App">
      {/* Header Navigation */}
      <header className="header">
        <nav className="nav">
          <div className="nav-brand">
            <h2>✈️ Airport Escape</h2>
          </div>
          <div className="nav-links">
            <a href="#story">Our Story</a>
            <a href="#features">Features</a>
            <a href="#team">Team</a>
            <a href="#download">Download</a>
          </div>
        </nav>
      </header>

      {/* Hero Section */}
      <section className="hero">
        <div className="container">
          <div className="hero-content">
            <h1>Airport Escape</h1>
            <p className="tagline">For passengers, by passengers</p>
            <p className="description">
              Born from the grand abyss of endless layover waits, five computer science students
              transformed their capstone project into a solution that turns airport delays into adventures.
            </p>
            <div className="hero-buttons">
              <button className="btn btn-primary">Coming Soon!</button>
              <a href="#story" className="btn btn-secondary">Read Our Story</a>
            </div>
          </div>
          <div className="hero-image">
            <div className="phone-mockup">
              📱<br />
              <small>Available on<br />iOS & Android</small>
            </div>
          </div>
        </div>
      </section>

      {/* Our Story Section */}
      <section id="story" className="story">
        <div className="container">
          <h2>The Story Behind Airport Escape</h2>

          <div className="story-content">
            <div className="story-text">
              <h3>🎓 A Capstone Project with Purpose</h3>
              <p>
                It started like many great ideas do - with a problem we all experienced. As five computer science
                students working on our capstone project, we thought back to times we traveled and found ourselves constantly frustrated during layovers.
                Hours of waiting in airports with no idea what was nearby, what we could explore, or if we even
                had enough time to leave the terminal.
              </p>

              <h3>💡 The "Aha!" Moment</h3>
              <p>
                During a team brainstorming session, one of us mentioned being stuck at Harry Reid International Airport for 6 hours with
                absolutely nothing to do. That's when we had our Eureka moment: what if we could create an app that not only
                showed you what's around your airport, but actually calculated whether you have enough time to
                visit based on your layover duration?
              </p>

              <h3>🚀 From Idea to Reality</h3>
              <p>
                What began as a semester project quickly evolved into something much bigger. We realized we weren't
                just building an app for a grade - we were solving a real problem that millions of travelers face
                every day. The more we developed, the more passionate we became about creating the perfect travel companion.
              </p>

              <h3>🌟 Our Mission</h3>
              <p>
                Today, Airport Escape represents our belief that every layover is an opportunity for adventure.
                We've built intelligent duration-based filtering, multi-language support, and a favorites system
                that learns from your preferences. Because travel should be about discovery, not just waiting.
              </p>
            </div>

            <div className="story-stats">
              <div className="stat-card">
                <div className="stat-number">11</div>
                <div className="stat-label">Languages Supported</div>
              </div>
              <div className="stat-card">
                <div className="stat-number">∞</div>
                <div className="stat-label">Airports Worldwide</div>
              </div>
              <div className="stat-card">
                <div className="stat-number">3+</div>
                <div className="stat-label">Activity Categories</div>
              </div>
              <div className="stat-card">
                <div className="stat-number">5</div>
                <div className="stat-label">Passionate Developers</div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Team Photo Section */}
      <section id="team" className="team-photo-section">
        <div className="container">
          <h2>Meet the Team</h2>
          <p className="team-intro">
            Five computer science students who turned their capstone project into a mission
            to transform how people experience layovers.
          </p>

          <div className="team-photo-container">
            <img
              src={teamPhoto}
              alt="Airport Escape Development Team"
              className="team-photo"
            />
            <div className="photo-caption">
              <p>The Airport Escape team during development of our capstone project</p>
            </div>
          </div>

          <div className="team-values">
            <div className="value-card">
              <h4>🎯 Problem Solvers</h4>
              <p>We identify real-world travel frustrations and build elegant solutions.</p>
            </div>
            <div className="value-card">
              <h4>✈️ Travel Enthusiasts</h4>
              <p>We understand layovers because we've lived through countless boring ones.</p>
            </div>
            <div className="value-card">
              <h4>💻 Tech Innovators</h4>
              <p>We leverage cutting-edge technology to create seamless user experiences.</p>
            </div>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section id="features" className="features">
        <div className="container">
          <h2>Why Airport Escape Works</h2>
          <div className="features-grid">
            <div className="feature-card">
              <div className="feature-icon">🎯</div>
              <h3>Smart Duration Filtering</h3>
              <p>Activities are automatically filtered based on your layover time. 3 hours = 10km radius, 6+ hours = 20km+ adventures.</p>
            </div>
            <div className="feature-card">
              <div className="feature-icon">🗺️</div>
              <h3>Google Maps Integration</h3>
              <p>Real-time distance calculations and interactive maps powered by Google Places API ensure accurate recommendations.</p>
            </div>
            <div className="feature-card">
              <div className="feature-icon">❤️</div>
              <h3>Personal Favorites</h3>
              <p>Save destinations with Firebase cloud sync. Your preferences follow you across all devices.</p>
            </div>
            <div className="feature-card">
              <div className="feature-icon">🌍</div>
              <h3>Global Accessibility</h3>
              <p>Available in 11 languages with support for airports worldwide. Travel barriers, eliminated.</p>
            </div>
          </div>
        </div>
      </section>

      {/* Download Section */}
      <section id="download" className="download">
        <div className="container">
          <h2>Ready for Your Next Adventure?</h2>
          <p>Download Airport Escape and turn your next layover into an exploration opportunity.</p>

          <div className="download-buttons">
            <button className="btn btn-download">
              📱 Download for iOS<br />
              <small>Coming Soon to App Store</small>
            </button>
            <button className="btn btn-download">
              🤖 Download for Android<br />
              <small>Coming Soon to Google Play</small>
            </button>
          </div>

          <div className="github-link">
            <a href="https://github.com/lenarduzziadam/AirportEscapeCapstoneFall25Group" className="btn btn-outline">
              🔍 View Source Code on GitHub
            </a>
          </div>

          <div className="capstone-note">
            <p><em>Proudly developed as our UWM Computer Science Capstone Project</em></p>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="footer">
        <div className="container">
          <div className="footer-content">
            <div className="footer-section">
              <h4>Airport Escape</h4>
              <p>"Making layovers an adventure, one destination at a time."</p>
            </div>
            <div className="footer-section">
              <h4>Project Info</h4>
              <p>Computer Science Capstone Project</p>
              <p>Fall 2025</p>
            </div>
            <div className="footer-section">
              <h4>Tech Stack</h4>
              <p>Flutter • Firebase • Google APIs</p>
              <p>React • Dart • JavaScript</p>
            </div>
          </div>
          <div className="footer-bottom">
            <p>&copy; 2025 Team Airport Escape. Built with ❤️ for travelers everywhere.</p>
          </div>
        </div>
      </footer>
    </div>
  )
}

export default App