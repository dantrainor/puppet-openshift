class mongodb::install {

	package { "mongodb":
		ensure				=> latest,
	}

	package { "mongodb-server":
		ensure				=> latest,
	}

}
