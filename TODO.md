# Feature
- Use RATP API to get Station next/prev
- create APIStub that use data file generated by the real API to replay scenario
- Display graph to show bus remaining time across the previous station, and to better visualize schedules prediction
- For buses, check that the destination is a station. If not its probably a few charaters away from a true station name
  So use fuzzy match to find the closest stations. Throw if it is too far from a real station

# UI
- add graph in pop-up when clicking on Leg
- show waiting time
- show start/end_time for each legs
- add visual cue about trip duration
