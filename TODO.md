# Project TODOs

## GitHub Push Steps
- [ ] 1. Install git (`sudo apt update &amp;&amp; sudo apt install git -y`)
- [x] 2. Create .gitignore and README.md (done)
- [ ] 3. git init
- [ ] 4. git add .
- [ ] 5. git commit -m "Initial commit: Assembly System Monitor with Flask UI"
- [ ] 6. git branch -M main
- [ ] 7. git remote add origin https://github.com/mamentudicky/Assembly-System-Monitoring.git
- [ ] 8. git push -u origin main
- [ ] 9. Verify repo on GitHub

Updated as steps complete.

---

# Original System Monitor Fix TODO

## Approved Plan Steps
- [x] 1. Read/verify print_num.asm (print_decimal func) - Fixed with buffer print
- [x] 2. Fix proc.asm: Proper /proc PID counting logic
- [ ] 3. Fix monitor.asm: Ensure cpu_load prints correctly (add explicit call if needed)
- [ ] 4. Update app.py: Robust parsing, clean output, defaults to &#39;-&#39;
- [ ] 5. Rebuild: make clean &amp;&amp; make
- [ ] 6. Test ./monitor output (confirm all 4 metrics print)
- [ ] 7. Run app.py and verify browser shows live real values
- [ ] 8. Final cleanup/debug if needed

Progress will be updated after each step.
