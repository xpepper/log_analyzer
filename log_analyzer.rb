class LogAnalyzer
  def initialize(log)
    @log = log
  end

  def report
    report = [] << "data risultati-2xx risultati-3xx risultati-4xx risultati-5xx"

    build_hash_report_for(@log).each do |date,response_codes|
      report << "#{date}\t#{response_codes['2xx']}\t#{response_codes['3xx']}\t#{response_codes['4xx']}"
    end

    report
  end

  private

  def build_hash_report_for(log)
    hashed_report = {}
    log.split("/n").each do |each_line|
      each_line.scan /\[(\d\d\/\w\w\w\/\d\d\d\d).+\].+\"\s(\d\d\d)/ do |date,response_code|
        hashed_report[date] ||= { "2xx" => 0, "3xx" => 0, "4xx" => 0 }
        hashed_report[date]["#{response_code.chars.first}xx"] += 1
      end
    end
    
    hashed_report
  end
end