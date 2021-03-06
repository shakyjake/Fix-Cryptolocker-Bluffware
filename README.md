# Fix files with .crypted on the end

I recently had a client become a victim of a cryptolocker scam. The catch, however, was that whoever built the software doesn't appear to know how to do the "crypto" part of cryptolocker. All the software did was add a .crypted extension to the end of the user's files. Mild inconvenience? Yes. Expensive catastrophe? Definitely not.

A post on a security forum called it "bluffware", which appears to be a speculative title rather than standard nomenclature but I quite like it so I'm running with it.

You should only run this **after you've removed the virus itself** using a malware removal tool or antivirus software (MalwareBytes is OK at this sort of thing).

## Will the fix work for you?

A good way to test this is to find an image (.jpg, or .png) that now has .crypted on the end and remove the .crypted part (right-click, rename). Then open the file. If the image displays normally then we're good to go.

_Note: Chrome may, somewhat ironically, flag this file as a virus so you may need to use a different browser to download it._
