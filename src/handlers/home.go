// Copyright 2019 The etcd Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package handlers

import (
	"net/http"
)

func HomeHandler(w http.ResponseWriter, r *http.Request) {
	http.Redirect(w, r,
		"https://github.com/etcd-io/etcd/blob/master/Documentation/v2/clustering.md#public-etcd-discovery-service",
		http.StatusMovedPermanently,
	)
}
