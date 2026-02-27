# Bolt ⚡ Learning Journal

- Found a critical performance issue where `FutureBuilder` inside a `StatelessWidget` caused the application to re-fetch Firestore data from the network on every rebuild.
- Critical learning: Always cache Futures inside `StatefulWidget`'s `initState` to prevent redundant computations and network requests during widget rebuilds.
