# C4Q_Weather_Code_Challenge

 ## Self Reflection
 
 I would the CollectionViewCell. I didn't spend a whole bunch of time on making it look pretty.

Realized late in the test that there are two dateTimeISO. One is nested into weatherCoded which is the one I went after. And the other dateTimeISO is just dictionary key in periods. 
 
 The dateTimeISO in weatherCoded can be nil or not exist. That caught me off guard. Should have spent more time looking at the data. Lesson learned. Made DateISO optional. I was running low on time so I would have like to handle nil in the model instead of handling it in the CollectionView Cell.

Made an Enum to handle Weather Errors but didn't get a chance to use it. 


