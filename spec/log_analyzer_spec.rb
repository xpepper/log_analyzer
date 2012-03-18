require "rubygems"
require "rspec"

require_relative '../log_analyzer'

describe LogAnalyzer do
  it "prints the header" do
    l = LogAnalyzer.new("")
    
    l.report[0].should == "data risultati-2xx risultati-3xx risultati-4xx risultati-5xx"
  end
  
  it "prints a line for each day in the log" do
    log =<<-EOF
    192.168.20.192 - - [29/Jul/2011:14:19:48 +0200] "GET / HTTP/1.1" 200 11870
    192.168.20.192 - - [29/Jul/2011:14:19:49 +0200] "GET /tomcat.png HTTP/1.1" 304 -
    192.168.20.192 - - [30/Jul/2011:14:20:39 +0200] "POST /phoenix-0.0/phoenixServlet HTTP/1.1" 200 264
    192.168.20.192 - - [30/Jul/2011:14:21:23 +0200] "GET /phoenix-0.0/tranpipe-demo/demo.html HTTP/1.1" 304 -
    192.168.20.191 - - [30/Jul/2011:15:48:04 +0200] "POST /phoenix-0.0/phoenixServlet HTTP/1.1" 200 263
    192.168.100.184 - - [01/Aug/2011:13:20:49 +0200] "GET /manager/status?XML=true HTTP/1.1" 401 2486
    EOF
    
    l = LogAnalyzer.new(log)
    
    l.report[1].should match /^29\/Jul\/2011/
    l.report[2].should match /^30\/Jul\/2011/
    l.report[3].should match /^01\/Aug\/2011/
  end
  
  it "prints the return codes occurrence in a day" do
    log =<<-EOF
    192.168.20.192 - - [29/Jul/2011:14:19:48 +0200] "GET / HTTP/1.1" 200 11870
    192.168.20.192 - - [29/Jul/2011:14:20:39 +0200] "POST /phoenix-0.0/phoenixServlet HTTP/1.1" 200 264
    192.168.20.192 - - [29/Jul/2011:14:21:23 +0200] "GET /phoenix-0.0/tranpipe-demo/demo.html HTTP/1.1" 304 -
    192.168.20.191 - - [30/Jul/2011:15:48:04 +0200] "POST /phoenix-0.0/phoenixServlet HTTP/1.1" 200 263
    192.168.100.184 - - [01/Aug/2011:13:20:49 +0200] "GET /manager/status?XML=true HTTP/1.1" 401 2486
    EOF
    
    l = LogAnalyzer.new(log)
    
    l.report[1].should match /^29\/Jul\/2011\t2\t1\t0/
  end

  it "prints the return codes occurrence in each day" do
    log =<<-EOF
    192.168.20.192 - - [29/Jul/2011:14:19:48 +0200] "GET / HTTP/1.1" 200 11870
    192.168.20.192 - - [29/Jul/2011:14:20:39 +0200] "POST /phoenix-0.0/phoenixServlet HTTP/1.1" 200 264
    192.168.20.192 - - [29/Jul/2011:14:21:23 +0200] "GET /phoenix-0.0/tranpipe-demo/demo.html HTTP/1.1" 304 -
    192.168.20.191 - - [30/Jul/2011:15:48:04 +0200] "POST /phoenix-0.0/phoenixServlet HTTP/1.1" 200 263
    192.168.20.191 - - [30/Jul/2011:15:48:04 +0200] "POST /phoenix-0.0/phoenixServlet HTTP/1.1" 200 263
    192.168.100.184 - - [01/Aug/2011:13:20:49 +0200] "GET /manager/status?XML=true HTTP/1.1" 200 2486
    192.168.100.184 - - [01/Aug/2011:13:20:49 +0200] "GET /manager/status?XML=true HTTP/1.1" 302 2486
    192.168.100.184 - - [01/Aug/2011:13:20:49 +0200] "GET /manager/status?XML=true HTTP/1.1" 401 2486
    EOF
    
    l = LogAnalyzer.new(log)
    
    l.report[1].should match /^29\/Jul\/2011\t2\t1\t0/
    l.report[2].should match /^30\/Jul\/2011\t2\t0\t0/
    l.report[3].should match /^01\/Aug\/2011\t1\t1\t1/
  end

  
end