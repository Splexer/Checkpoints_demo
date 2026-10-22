
A modified demo 3D scene by Kenny. 
I’ve implemented a checkpoint system with world-state rollback.

<img width="1276" height="707" alt="image" src="https://github.com/user-attachments/assets/03be4c3a-002b-4856-ab4a-f5f4753aa518" />

Checkpoints are new objects—red flags. To activate one, approach it and press the E key.

When a checkpoint is activated, it records the current state of the world and the player. If the player falls, both the player and the world will revert to this saved state.

Only one checkpoint can be active at a time, however, they are reusable and can be used multiple times in any order.
