Delegate.RegDelTalkEvent("prtest_TalkEvent");
function prtest_TalkEvent(player,msg,color,range,size)
        -- ∏Ò Ω /testride ∆Ô≥Ë±‡∫≈
        if(string.find (msg,"/testride"))then
                if xx1 == 0 then
                        local sv = string.gsub(msg, "/testride ", "");
                        NLG.SystemMessage(player,sv);
                        NLG.SetRideEffect(player,tonumber(sv),600)
                        xx1=1
                else
                        NLG.SetRideEffect(player,-1,100)
                        xx1=0
                end
        end
end