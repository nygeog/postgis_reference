mergeTableName = 'tracts_2010_us'
attrList       = ['geoid10', 'aland10', 'awater10', 'intptlat10', 'intptlon10', 'shape_leng', 'shape_area', 'geom']
attrListString = ", ".join(attrList)

statesList = ["01","02","04","05","06","08","09","10","11","12","13","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","44","45","46","47","48","49","50","51","53","54","55","56","72"]

e1 = """CREATE TABLE """+mergeTableName+""" AS(""" 

print e1

e3 = """UNION"""

statesListLen = len(statesList)

for i, item in enumerate(statesList):
	e2 = """SELECT """+attrListString+""" FROM tracts_2010_state_"""+item
	print e2
	if i < (statesListLen - 1):
		print e3

e4 = """);"""

e5 = """SELECT Populate_Geometry_Columns('""" + mergeTableName + """'::regclass);"""

print e4
print e5