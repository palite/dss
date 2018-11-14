'use strict';
const mongoose = require('mongoose');
const User = mongoose.model('User');
const VerifEmail = mongoose.model('VerifEmail');

const nodemailer = require('nodemailer');
const hash = require('object-hash');

var smtpTransport = nodemailer.createTransport({
    name: 'smtp2go',
    host: 'mail.smtp2go.com',
    port: 587,
    secure: false, // true for 465, false for other ports
    auth: {
        user:  "kukuh.raharjo1923@gmail.com",
        pass:  "kkrdoto"
    }
})

exports.signUp = function (req,res) {
    console.log(process.env.MAILPASS);
    User.find({identitas: req.body.userId})
        .then((doc) => {
            if (doc[0] != null) {
                var data = {
                    "exist" : true
                }
                res.send(data);
            }
            else {
                var rand = Math.floor((Math.random()*8999)+1000);
                var pesan = "Hai, \n"" \n Masukkan kode "+rand;
               var mailOptions = {
                    from: 'Kukuh_kr <kukuhkr@email.com>',
                    to : req.body.userId,
                    subject : "Masukkan kode berikut ke hpmu nak",
                    html : "Hai, "+req.body.name+ " <br> Masukkan kode "+rand+" ke hpmu nak."
                }
                console.log(mailOptions);
                smtpTransport.sendMail(mailOptions, function(error,info){
                    if (error) {
                        console.log(error);
                        res.send("eror");
                    } else {
                        //console.log('Message sent: %s', info.messageId);
                        // Preview only available when sending through an Ethereal account
                        //console.log('Preview URL: %s', nodemailer.getTestMessageUrl(info));
                        console.log(info);
                        var data = {
                            "exist" : false
                        }
                        res.send(data);

                    }
                });
                VerifEmail.findOneAndUpdate({identitas : req.body.userId,password : hash(req.body.password)},{$set:{kode : rand}},{upsert : true, new : true}, function (err,file) {
                    if (err) {
                        console.log("update eror");
                    }
                    console.log(file);

                });
            }
        })
        .catch((err) => {
            console.log(err);
        })
    
}

exports.verifEmail = function (req,res) {
    VerifEmail.findOneAndRemove({identitas: req.body.userId,kode: req.body.code}, function (err,doc){
        if (err) {
            console.log("verif gagal");
        }
        else if (doc != null) {
             User.findOneAndUpdate({identitas: req.body.oldUserId,password: hash(req.body.password)}, {$set:{identitas: req.body.userId}}, function (err,info){
                if (err) {
                    console.log("eror,eror,eror,eror");
                } else if (info == null) {
                    var dataId = new User({
                        "identitas" : req.body.userId,
                        "password" : hash(req.body.password)
                    });
                    dataId.save();
                    console.log(info);
                } else {
    
                }
                
            }); 
            var data = {
                "iscodetrue" : true
            }
            res.send(data);
        } else {
            var data = {
                "iscodetrue" : false
            }
            res.send(data);
        }
        
    });
}

exports.logIn = function (req,res) {
    User.findOneAndUpdate({identitas: req.body.userId,password:hash(req.body.password)}, {},{new:true}, function(err,doc){
        if (err){
            console.log("Login gagal");
        }
        console.log(doc);
        if (doc != null){
            User.find({identitas: req.body.userId}).distinct('nama')
            .then((nama) => {
                var data = {
                    "isloggedin" : true
                }    
                res.send(data);
            })
        }
        else {
            var data = {
                "isloggedin" : false
            }
            res.send(data);
        }
        
    });
}