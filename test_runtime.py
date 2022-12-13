import pytest
import requests

LAMBDA_URL = "http://localhost:9000/2015-03-31/functions/function/invocations"

def test_runtime():
    r1 = requests.post(LAMBDA_URL, json={'data': 'marco'})
    result1 = r1.json()
    r2 = requests.post(LAMBDA_URL, json={'data': 'alpha'})
    result2 = r2.json()
    assert result1['body'] == "polo"
    assert result1['statuscode'] == 200
    assert result2['body'] == "beta"
    assert result2['statuscode'] == 200