REGEX = {}

# Regular expression to extract link to youtube video
# text.scan(REGEX[:youtube])[*][4] - ID of the *th video in text
# ID contains aplhanumerical characters
REGEX[:youtube] = /(youtu\.be\/|youtube\.com\/(watch\?(\S*&)?v=|(embed|v)\/))(\w+)/

# Regular expression to extract link to vimeo video
# text.scan(REGEX[:vimeo])[*][2] - ID of the *th video in text
# ID is an integer
REGEX[:vimeo] = /(https?:\/{2})?(www\.)?vimeo\.com\/(\d*)/