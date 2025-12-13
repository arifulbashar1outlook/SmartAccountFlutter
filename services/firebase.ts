import { initializeApp } from "firebase/app";
import { getAuth, GoogleAuthProvider, signInWithPopup, signOut as firebaseSignOut } from "firebase/auth";
import { getDatabase, ref, set, get, child } from "firebase/database";
import { Transaction } from "../types";

// Helper to check if a string is non-empty
const hasValue = (val: string | undefined) => val && val !== "" && val !== "undefined";

// Vite replaces process.env.KEY with the actual string value during build.
// We must access them directly, not dynamically via array index.
const firebaseConfig = {
  apiKey: process.env.FIREBASE_API_KEY,
  authDomain: process.env.FIREBASE_AUTH_DOMAIN,
  projectId: process.env.FIREBASE_PROJECT_ID,
  storageBucket: process.env.FIREBASE_STORAGE_BUCKET,
  messagingSenderId: process.env.FIREBASE_MESSAGING_SENDER_ID,
  appId: process.env.FIREBASE_APP_ID,
  databaseURL: process.env.FIREBASE_DATABASE_URL
};

// Initialize Firebase only if config exists and is valid
let app;
let auth: any = null;
let db: any = null;

try {
  // Check if critical keys exist before initializing
  if (hasValue(firebaseConfig.apiKey) && hasValue(firebaseConfig.authDomain)) {
    app = initializeApp(firebaseConfig);
    auth = getAuth(app);
    db = getDatabase(app);
  } else {
    console.warn("Firebase config missing. Cloud sync disabled.");
  }
} catch (error) {
  console.error("Firebase initialization failed:", error);
}

export { auth, db };

export const signInWithGoogle = async () => {
  if (!auth) {
    alert("Firebase is not configured. Please add your FIREBASE_API_KEY and other credentials to the environment variables.");
    throw new Error("Firebase not initialized");
  }
  const provider = new GoogleAuthProvider();
  try {
    const result = await signInWithPopup(auth, provider);
    return result.user;
  } catch (error) {
    console.error("Error signing in", error);
    throw error;
  }
};

export const logout = async () => {
  if (!auth) return;
  try {
    await firebaseSignOut(auth);
  } catch (error) {
    console.error("Error signing out", error);
  }
};

export const saveUserData = async (userId: string, transactions: Transaction[]) => {
  if (!db) return;
  try {
    await set(ref(db, 'users/' + userId), {
      transactions: transactions,
      lastUpdated: new Date().toISOString()
    });
  } catch (error) {
    console.error("Error saving data", error);
  }
};

export const getUserData = async (userId: string): Promise<Transaction[] | null> => {
  if (!db) return null;
  try {
    const dbRef = ref(db);
    const snapshot = await get(child(dbRef, `users/${userId}`));
    if (snapshot.exists()) {
      const data = snapshot.val();
      return data.transactions || [];
    } else {
      return null;
    }
  } catch (error) {
    console.error("Error fetching data", error);
    return null;
  }
};