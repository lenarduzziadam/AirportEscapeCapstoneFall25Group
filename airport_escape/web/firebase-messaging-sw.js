importScripts('https://www.gstatic.com/firebasejs/9.23.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.23.0/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "AIzaSyCMibcVDhsc7K3lxtFW-joHL5nX3Ld3PWI",
  appId: "1:987633027135:web:4cd849bfd22441f315508a",
  messagingSenderId: "987633027135",
  projectId: "airport-escape"
});

const messaging = firebase.messaging();
