function harvester -d "Lazy defaults for theHarvester"
    theHarvester \
        -b anubis,baidu,bing,bingapi,bufferoverun,certspotter,crtsh,dnsdumpster,duckduckgo,github-code,hackertarget,intelx,linkedin,linkedin_links,omnisint,otx,projectdiscovery,qwant,rapiddns,securityTrails,sublist3r,threatcrowd,threatminer,trello,twitter,urlscan,virustotal,yahoo \
        -d $argv -svrf "$argv.html"
end
