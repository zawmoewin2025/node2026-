#!/bin/sh

# ၁။ Xray ကို background မှာ run မယ် (Port 8080)
/usr/bin/xray -config /etc/xray/config.json &

# ၂။ Cloudflare Tunnel ကို background မှာ run မယ်
# TUNNEL_TOKEN ဆိုတဲ့နေရာမှာ သင့်ရဲ့ Token အစစ်ကို ထည့်ပါ
# ဒါမှမဟုတ် Settings > Variables ထဲမှာ TUNNEL_TOKEN အမည်နဲ့ သိမ်းထားရင် ပိုကောင်းပါတယ်
/usr/bin/cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN} &

# ၃။ Web Server (Python) ကို Port 3000 မှာ run မယ် (ဒါမှ 503 ပျောက်မှာပါ)
cd /etc/xray && python3 -m http.server 3000
