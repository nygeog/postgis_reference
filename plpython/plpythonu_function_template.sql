CREATE OR REPLACE FUNCTION plpython_test()
RETURNS numeric
AS $$

import numpy as np

var = np.random.random(100)

return np.max(var)

$$ LANGUAGE plpythonu;