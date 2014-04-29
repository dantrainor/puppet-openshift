# Copyright 2013 Mojo Lingo LLC.
# Modifications by Red Hat, Inc.
# 
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
# 
#      http://www.apache.org/licenses/LICENSE-2.0
# 
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#


class modprobe::config{
      file { '/etc/sysconfig/modules/bridge.modules':
        content => "#!/bin/bash\nexec /sbin/modprobe bridge >/dev/null 2>&1",
        mode    => '700',
      }

      exec { 'load bridge module':
        command => '/sbin/modprobe bridge',
      }
}

