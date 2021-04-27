# Import dependencies
import subprocess
import json
import os
from bit import wif_to_key
from dotenv import load_dotenv


# Load and set environment variables
load_dotenv()
mnemonic=os.getenv("mnemonic")
priv_key = os.getenv('mnemonic_private_key')

# Import constants.py and necessary functions from bit and web3
from constraints import *
 
 
# Create a function called `derive_wallets`
def derive_wallets(coin,mnemonic):
    command = './derive -g --mnemonic="%s" --cols=path,address,privkey,pubkey --format=json --coin="%s" --numderive=3'%(mnemonic,coin) #--coin='ETH'
    p = subprocess.Popen(command, stdout=subprocess.PIPE, shell=True) #Opens up terminal and runs child program in new process
    output, err = p.communicate() #communicate with terminal as the command is being run
    p_status = p.wait()
    return json.loads(output)

# Create a dictionary object called coins to store the output from `derive_wallets`.
#coins = dict(derive_wallets(mnemonic))

# Create a function called `priv_key_to_account` that converts privkey strings to account objects.
def priv_key_to_account(coin,priv_key):
    if coin == 'ETH':
        return derive_wallets(priv_key)
    elif coin == 'BTCTEST':
        return wif_to_key(priv_key)
    else:
        print("No solution for that coin type")
        return None

# Create a function called `create_tx` that creates an unsigned transaction appropriate metadata.
def create_tx(coin, account, to, amount):
    if coin == 'ETH':
        return derive_wallets(priv_key)
    elif coin == 'BTCTEST':
        return wif_to_key(priv_key)
    else:
        print("No solution for that coin type")
        return None

# Create a function called `send_tx` that calls `create_tx`, signs and sends the transaction.
#def send_tx(# YOUR CODE HERE):
    # YOUR CODE HERE

