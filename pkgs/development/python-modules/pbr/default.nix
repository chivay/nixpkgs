{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, callPackage
}:

buildPythonPackage rec {
  pname = "pbr";
  version = "5.10.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-z8xP+OaYJW/BfqP/eWR4sFCFJYWqW6557NBbKrezm5o=";
  };

  # importlib-metadata could be added here if it wouldn't cause an infinite recursion
  propagatedBuildInputs = [ setuptools ];

  # check in passthru.tests.pytest to escape infinite recursion with fixtures
  doCheck = false;

  passthru.tests = {
    tests = callPackage ./tests.nix { };
  };

  pythonImportsCheck = [ "pbr" ];

  meta = with lib; {
    description = "Python Build Reasonableness";
    homepage = "https://github.com/openstack/pbr";
    license = licenses.asl20;
    maintainers = teams.openstack.members;
  };
}
