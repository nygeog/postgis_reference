import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('postgresql://scott:tiger@localhost:5432/mydatabase')
#df.to_sql('table_name', engine)