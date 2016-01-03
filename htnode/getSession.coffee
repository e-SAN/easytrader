
async = require 'async'
request = require 'request'
ocr =  require 'ocr-by-image-url'
hddInfo = 'ST9120817AS' # require './hddInfo.coffee.md'
address = require 'address'


vcurl = "https://service.htsc.com.cn/service/pic/verifyCodeImage.jsp?ran=#{Math.random()}"

obj =
  vcode: (callback)-> setTimeout (-> ocr.getImageText vcurl, callback), 800
  ipmac: (callback)-> setTimeout (-> address callback), 400

async.parallel obj, (err,results)->
    {ipmac:{ip,ipv4,mac}, vcode} = results
    # 緊接著就登錄
    url = "https://service.htsc.com.cn/service/loginAction.do?method=login"
    #text = "userType=jy&loginEvent=1&trdpwdEns=2d8c0c21d479305c539e7a49ecd87d4d&macaddr=60:33:4B:09:BF:0F&hddInfo=#{hddInfo}&lipInfo=#{ip}&CPU=QkZFQkZCRkYwMDAzMDY2MQ%3D%3D&PCN=U0RXTS0yMDEzMDkxNFNX&PI=QyxOVEZTLDYwLjAwMzg%3D&topath=null&accountType=1&userName=080300007199&servicePwd=19660522&trdpwd=2d8c0c21d479305c539e7a49ecd87d4d&vcode=#{vcode.trim()}"

    options =
      userType: 'jy'
      loginEvent:1
      trdpwdEns: '196605'
      macaddr:'60:33:4B:09:BF:0F'
      hddInfo: "#{hddInfo}"
      lipInfo: "#{ip}"
      topath: null
      accountType: 1
      userName: '080300007199'
      servicePwd: '19660522'
      trdpwd: '196605'
      vcode: "#{vcode.trim()}"

    #request.post url+'&'+text, (err, data)-> console.log data unless err
    request.get
      url: url
      forever: true
      jar: true
      form: options
      (error ,response, body)->
        if error?
          console.err errore
        else
          console.log response.headers unless err
