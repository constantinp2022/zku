
Steps I fallowed:
	Step 1. sudo apt  install cargo
	Step 2. sudo apt  install curl
	Step 3. Fallow circum install guide
	Step 4. export PATH="~/.cargo/bin"$PATH  <-----It depens on your machine
	Step 5. uninstall and install of nodejs as I have a old version v10 update to 17.6
		Issue:  npm install -g snarkjs
				npm does not support Node.js v10.19.0
				You should probably upgrade to a newer version of node as we
				can't make any promises that npm will work with this version.
				You can find the latest version at https://nodejs.org/
				/usr/local/lib/node_modules/npm/lib/npm.js:32
				#unloaded = false
				^

				SyntaxError: Invalid or unexpected token
					at Module._compile (internal/modules/cjs/loader.js:723:23)
					at Object.Module._extensions..js (internal/modules/cjs/loader.js:789:10)
					at Module.load (internal/modules/cjs/loader.js:653:32)
					at tryModuleLoad (internal/modules/cjs/loader.js:593:12)
					at Function.Module._load (internal/modules/cjs/loader.js:585:3)
					at Module.require (internal/modules/cjs/loader.js:692:17)
					at require (internal/modules/cjs/helpers.js:25:18)
					at module.exports (/usr/local/lib/node_modules/npm/lib/cli.js:22:15)
					at Object.<anonymous> (/usr/local/lib/node_modules/npm/bin/npm-cli.js:2:25)
					at Module._compile (internal/modules/cjs/loader.js:778:30)'
	Step 6. npm install -g snarkjs    <----- Soem commands must be run wih sudo Eacces got if not
	Step 7. git clone https://github.com/iden3/circomlib
	Step 8. For better understanding run the example circom exercise
Next steps are for building example circom:
	Step 9. install nlohmann json ubuntu command: sudo apt-get install nlohmann-json3-dev
	step 10. sudo apt-get install libgmp3-dev
	Step 11. sudo apt-get install -y nasm